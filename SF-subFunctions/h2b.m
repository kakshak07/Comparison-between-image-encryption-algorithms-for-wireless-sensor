function b = h2b(h)
switch h
    case {'0'}
        b = logical([0 0 0 0]);
    case {'1'}
        b = logical([0 0 0 1]);
    case {'2'}
        b = logical([0 0 1 0]);
    case {'3'}
        b = logical([0 0 1 1]);
    case {'4'}
        b = logical([0 1 0 0]);
    case {'5'}
        b = logical([0 1 0 1]);
    case {'6'}
        b = logical([0 1 1 0]);
    case {'7'}
        b = logical([0 1 1 1]);
    case {'8'}
        b = logical([1 0 0 0]);
    case {'9'}
        b = logical([1 0 0 1]);
    case {'A', 'a'}
        b = logical([1 0 1 0]);
    case {'B', 'b'}
        b = logical([1 0 1 1]);
    case {'C', 'c'}
        b = logical([1 1 0 0]);
    case {'D', 'd'}
        b = logical([1 1 0 1]);
    case {'E', 'e'}
        b = logical([1 1 1 0]);
    case {'F', 'f'}
        b = logical([1 1 1 1]);
end