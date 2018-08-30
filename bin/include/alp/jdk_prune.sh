#!/bin/bash

JDK_HOME="$1"

echo "Alpine: prune unnecessary folders/files: $JDK_HOME"

sudo rm -rf "$JDK_HOME/"*src.zip && \
sudo rm -rf "$JDK_HOME/lib/missioncontrol" \
       "$JDK_HOME/lib/visualvm" \
       "$JDK_HOME/lib/"*javafx* \
       "$JDK_HOME/jre/lib/plugin.jar" \
       "$JDK_HOME/jre/lib/ext/jfxrt.jar" \
       "$JDK_HOME/jre/bin/javaws" \
       "$JDK_HOME/jre/lib/javaws.jar" \
       "$JDK_HOME/jre/lib/desktop" \
       "$JDK_HOME/jre/plugin" \
       "$JDK_HOME/jre/lib/"deploy* \
       "$JDK_HOME/jre/lib/"*javafx* \
       "$JDK_HOME/jre/lib/"*jfx* \
       "$JDK_HOME/jre/lib/amd64/libdecora_sse.so" \
       "$JDK_HOME/jre/lib/amd64/"libprism_*.so \
       "$JDK_HOME/jre/lib/amd64/libfxplugins.so" \
       "$JDK_HOME/jre/lib/amd64/libglass.so" \
       "$JDK_HOME/jre/lib/amd64/libgstreamer-lite.so" \
       "$JDK_HOME/jre/lib/amd64/"libjavafx*.so \
       "$JDK_HOME/jre/lib/amd64/"libjfx*.so && \
sudo rm -rf "$JDK_HOME/jre/bin/jjs" \
       "$JDK_HOME/jre/bin/keytool" \
       "$JDK_HOME/jre/bin/orbd" \
       "$JDK_HOME/jre/bin/pack200" \
       "$JDK_HOME/jre/bin/policytool" \
       "$JDK_HOME/jre/bin/rmid" \
       "$JDK_HOME/jre/bin/rmiregistry" \
       "$JDK_HOME/jre/bin/servertool" \
       "$JDK_HOME/jre/bin/tnameserv" \
       "$JDK_HOME/jre/bin/unpack200" \
       "$JDK_HOME/jre/lib/ext/nashorn.jar" \
       "$JDK_HOME/jre/lib/jfr.jar" \
       "$JDK_HOME/jre/lib/jfr" \
       "$JDK_HOME/jre/lib/oblique-fonts" && \
# sudo rm "${JDK_HOME}/jre/lib/security/README.txt" && \
echo "JDK pruned for Alpine"

