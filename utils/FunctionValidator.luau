local _,GlobalEnvironment = pcall(function()
    return (
        getgenv or get_genv or get_g_env
        or getglobalenv or get_globalenv or get_global_env
        or getglobalenvironment or get_globalenvironment or get_global_environment
    )()
end)

if not GlobalEnvironment then
    return nil
end

local FunctionValidator = {}

function FunctionValidator.Validate(FunctionName: string, Fallback: (...any) -> any, IsSolara: boolean?)
    if FunctionName == "hookmetamethod" and IsSolara then
        return Fallback
    end

    local Function = rawget(GlobalEnvironment, FunctionName) or GlobalEnvironment[FunctionName]

    if not Function or typeof(Function) ~= "function" then
        return Fallback
    end

    return Function
end

return FunctionValidator
