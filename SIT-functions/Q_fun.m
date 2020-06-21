function O = Q(I)
if(I==logical([0 0 0 0]))
        O = logical([1 0 0 1]); end
if(I==logical([0 0 0 1]))
        O = logical([1 1 1 0]); end
if(I==logical([0 0 1 0]))
        O = logical([0 1 0 1]); end
if(I==logical([0 0 1 1]))
        O = logical([0 1 1 0]); end
if(I==logical([0 1 0 0]))
        O = logical([1 0 1 0]); end
if(I==logical([0 1 0 1]))
        O = logical([0 0 1 0]); end
if(I==logical([0 1 1 0]))
        O = logical([0 0 1 1]); end
if(I==logical([0 1 1 1]))
        O = logical([1 1 0 0]); end
if(I==logical([1 0 0 0]))
        O = logical([1 1 1 1]); end
if(I==logical([1 0 0 1]))
        O = logical([0 0 0 0]); end
if(I==logical([1 0 1 0]))
        O = logical([0 1 0 0]); end
if(I==logical([1 0 1 1]))
        O = logical([1 1 0 1]); end
if(I==logical([1 1 0 0]))
        O = logical([0 1 1 1]); end
if(I==logical([1 1 0 1]))
        O = logical([1 0 1 1]); end
if(I==logical([1 1 1 0]))
        O = logical([0 0 0 1]); end
if(I==logical([1 1 1 1]))
        O = logical([1 0 0 0]); end
end