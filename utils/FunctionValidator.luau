local _,GlobalEnvironment = pcall(function()
    return {}
end)

if not GlobalEnvironment then
    return nil
end

local FunctionValidator = {}

function FunctionValidator.Validate(FunctionName: string | {string}, Fallback: (...any) -> any, IsSolara: boolean?)
    if type(FunctionName) == "table" then
        if FunctionName.hookmetamethod and IsSolara then
            return Fallback
        end

        for _,Name in next, FunctionName do
            local Function = GlobalEnvironment[Name]
            if Function and type(Function) == "function" then
                return Function
            end
        end
        return Fallback
    end

    local Function = GlobalEnvironment[FunctionName]
    if not Function or type(Function) ~= "function" then
        return Fallback
    end
    return Function
end

return FunctionValidator
