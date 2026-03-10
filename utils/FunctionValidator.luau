local _,Environment = pcall(function()
    return (
        getgenv or get_genv or getg_env or get_g_env
        or getglobalenv or get_globalenv or getglobal_env or get_global_env
        or getglobalenvironment or get_globalenvironment  or getglobal_environment or get_global_environment
    )()
end)

if not Environment then
    Environment = getfenv(0)
    if not Environment then
        return nil, "broken ass executor :skull:"
    end
end

local FunctionValidator = {}

function FunctionValidator.Validate(Name: string | {string}, Fallback: (...any) -> any, IsSolara: boolean?)
    if type(Name) == "table" then
        if Name[1] == "hookmetamethod" and IsSolara then
            return Fallback
        end

        for _,FunctionName in next, Name do
            local Function = rawget(Environment, FunctionName) or Environment[FunctionName]
            if Function and type(Function) == "function" then
                return Function
            end
        end
        return Fallback
    end

    local Function = rawget(Environment, Name) or Environment[Name]
    if not Function or type(Function) ~= "function" then
        return Fallback
    end
    return Function
end

return FunctionValidator
