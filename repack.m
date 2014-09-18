function packed_func = repack(func, transpose)
% REPACK  Wraps func to return a matrix of all return values of func
%     packed = repack(func)  wrapper returns a horizontal matrix
%     packed = repack(func, false)  wrapper returns a horizontal matrix
%     packed = repack(func, true)  wrapper returns a vertical matrix
    if nargin < 2
        transpose = false
    end
    n_output = nargout(func);
    function p = packed(varargin)
        [output{1:n_output}] = func(varargin{:});
        p = cell2mat(output);
        if transpose == true
            p = p';
        end
    end
    packed_func = @packed;
end
