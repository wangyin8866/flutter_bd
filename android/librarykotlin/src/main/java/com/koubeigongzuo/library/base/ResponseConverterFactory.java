package com.koubeigongzuo.library.base;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.TypeAdapter;
import com.google.gson.reflect.TypeToken;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Converter;
import retrofit2.Retrofit;

import java.lang.annotation.Annotation;
import java.lang.reflect.Type;
import java.util.List;

/**
 * @author : created by wyman
 * @date : 2019-07-15 14:43
 * des : copy 源码中自定义的ConverterFactory
 */
public class ResponseConverterFactory extends Converter.Factory {
    public static ResponseConverterFactory create() {

        //GSON 数据容错实例
        return create(
                new GsonBuilder()
                        .setDateFormat("yyyy-MM-dd HH:mm:ss")
                        .registerTypeAdapter(Integer.class, new IntDefault0Adapter())
                        .registerTypeAdapter(int.class, new IntDefault0Adapter())
                        .registerTypeHierarchyAdapter(List.class, new ArraySecurityAdapter())
                        .create());
    }

    public static ResponseConverterFactory create(Gson gson) {
        return new ResponseConverterFactory(gson);
    }

    private final Gson gson;

    public ResponseConverterFactory(Gson gson) {
        if (gson == null) {
            throw new NullPointerException("gson == null");
        }
        this.gson = gson;
    }

    @Override
    public Converter<ResponseBody, ?> responseBodyConverter(Type type, Annotation[] annotations, Retrofit retrofit) {
        TypeAdapter<?> adapter = gson.getAdapter(TypeToken.get(type));
        return new GsonResponseBodyConverterEr<>(gson, adapter);
    }

    @Override
    public Converter<?, RequestBody> requestBodyConverter(Type type, Annotation[] parameterAnnotations, Annotation[] methodAnnotations, Retrofit retrofit) {
        TypeAdapter<?> adapter = gson.getAdapter(TypeToken.get(type));
        return new GsonRequestBodyConverterEr<>(gson, adapter);

    }
}
