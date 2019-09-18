package com.koubeigongzuo.library.base;

import com.google.gson.*;

import java.lang.reflect.Type;

/**
 * @author : created by wyman
 * @date : 2019-07-24 10:43
 * des :
 */
public class IntDefault0Adapter implements JsonDeserializer<Integer>,JsonSerializer<Integer> {
    @Override
    public Integer deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
        if ("".equals(json.getAsString())) {
            return 0;
        }
        try {
            return json.getAsInt();
        } catch (NumberFormatException e) {
            return 0;
        }
    }
    @Override
    public JsonElement serialize(Integer src, Type typeOfSrc, JsonSerializationContext context) {
        return new JsonPrimitive(src);
    }
}
