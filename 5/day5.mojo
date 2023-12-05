@value
struct Mapping(CollectionElement):
    var src: Int 
    var dest: Int 
    var length: Int

    fn includes_range(self, start: Int, end:Int) -> Bool:
        if start >= self.src and start < (self.src + self.length):
            return True
        
        if end > self.src and end < (self.src + self.length):
            return True

        if start < self.src and end > (self.src + self.length):
            return True
        
        return False


@value
struct DynamicVectorWrap(CollectionElement):
    var mappings: DynamicVector[Mapping]

    fn append(inout self, mapping: Mapping):
        self.mappings.append(mapping)
    
    fn __len__(self) -> Int:
        return len(self.mappings)

    
fn parse_mapping(line: String) raises -> Mapping:
    var parts = line.split(" ")
    return Mapping(
        src = atol(parts[1]),
        dest = atol(parts[0]),
        length = atol(parts[2])
    )


fn parse_seeds_a(line: String) raises -> DynamicVector[Mapping]:
    var parts = line.split(" ")
    var seeds = DynamicVector[Mapping] ()
    for i in range(1, len(parts)):
        seeds.append(Mapping(
            src = atol(parts[i]),
            dest = -1,
            length = 1
        ))
    return seeds


fn parse_seeds_b(line: String) raises -> DynamicVector[Mapping]:
    var parts = line.split(" ")
    var seeds = DynamicVector[Mapping] ()
    for i in range(1, len(parts),2):
        seeds.append(Mapping(
            src = atol(parts[i]),
            dest = -1,
            length = atol(parts[i+1])
        ))
    return seeds


fn is_digit(c: String) -> Bool:
    return ord(c) >= ord('0') and ord(c) <= ord('9')


fn min(a: Int, b: Int) -> Int:
    if a < b:
        return a
    else:
        return b


let INTMAX:Int = 100000000000
def recurse_mapping(start: Int, end: Int, level: Int, mappingChain: DynamicVector[DynamicVectorWrap], passthrough: Bool) -> Int:
    let mappings = mappingChain[level].mappings
    var retMin = INTMAX 

    for j in range(len(mappings)):
        let mapping = mappings[j]
        if mapping.includes_range(start, end):
            # we have 3 cases here 
            var before_val = INTMAX
            var after_val = INTMAX
            
            if mapping.src > start:
                before_val = recurse_mapping(start, mapping.src, level, mappingChain,True)
                
            if mapping.src + mapping.length < end:
                after_val = recurse_mapping(mapping.src + mapping.length, end, level, mappingChain,True)
          
            
            let insideStart =  mapping.src  if mapping.src > start else start
            let insideEnd =  mapping.src + mapping.length if mapping.src + mapping.length < end  else end
            
            let offset = mapping.dest - mapping.src
            var insideVal = insideStart + offset
            if level < len(mappingChain) - 1:
                insideVal = recurse_mapping(insideStart + offset, insideEnd + offset, level+1, mappingChain,True)

            retMin =  min(insideVal, min(before_val, after_val))
            return retMin
    
    if level < len(mappingChain) - 1:
        retMin = recurse_mapping(start, end, level+1, mappingChain,True)
    else:
        retMin = start

    return retMin


fn load_file(file: String) raises :

    let f = open(file, "r")

    let lines = f.read().split("\n")
    
    var newMapping: DynamicVector[Mapping] = DynamicVector[Mapping] ()

    var seeds_a: DynamicVector[Mapping] = DynamicVector[Mapping] ()
    var seeds_b: DynamicVector[Mapping] = DynamicVector[Mapping] ()

    # var mappingChain: InlinedFixedVector[DynamicVector[Mapping],1000] = InlinedFixedVector[DynamicVector[Mapping],1000] (1000)
    var mappingChain = DynamicVector[DynamicVectorWrap]()

    for i in range(len(lines)):
        let line = lines[i]
        print(line)
        if line[:5]=="seeds":
            seeds_a = parse_seeds_a(line)
            seeds_b = parse_seeds_b(line)

        elif line == "":
            if len(newMapping) > 0:
                mappingChain.append(DynamicVectorWrap(mappings = newMapping))
                newMapping = DynamicVector[Mapping] ()
            newMapping = DynamicVector[Mapping] () 
        elif is_digit(line[0]):
            newMapping.append(parse_mapping(line))

    if len(newMapping) > 0:
        mappingChain.append(newMapping) 

    def min_loc(seeds:DynamicVector[Mapping]) -> Int:
        var minLoc: Int = 2000000000

        for i in range(len(seeds)):
            let seed = seeds[i]
            let seedStart = seed.src
            let seedEnd = seed.src + seed.length
            let minval = recurse_mapping(seedStart, seedEnd, 0, mappingChain,True)

            if minval < minLoc:
                minLoc = minval

        return minLoc

    print("A",min_loc(seeds_a))
    print("B",min_loc(seeds_b))
    print("Done")

fn main() raises:
    load_file("input.test.txt")
    load_file("input.txt")
