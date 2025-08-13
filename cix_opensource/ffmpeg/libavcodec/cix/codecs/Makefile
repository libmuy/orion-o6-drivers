OBJS-$(CONFIG_CIX_DSP_MP3_DECODER)	+= cix/codecs/cix_mp3_dec.o

libavcodec/cix/codecs/%.o: CPPFLAGS += -I${PATH_EXPORT_INCLUDE} -I$(SRC_PATH)/libavcodec/ -I$(SRC_PATH)/libavcodec/cix/libs/

clean::
	$(RM) $(CLEANSUFFIXES:%=libavcodec/cix/codecs/%)

