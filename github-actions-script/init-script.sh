echo $(pwd)
echo "-----------------init-script started-------------"
ls -al
ARTIFACTORY_URL="https://devopsamiya.jfrog.io/artifactory/api/npm"
ARTIFACTORY_BASE_URL="https://devopsamiya.jfrog.io/artifactory"
ARTIFACTORY_RELEASE="releases-npm"
ARTIFACTORY_SNAPSHOTS="snapshots-npm"
echo `VARIABLE_FILE : $VARIABLE_FILE`
touch $VARIABLE_FILE
GROUP_ID=$(mvn help:evaluate -Dexpression=project.groupId -q DforceStdout)
export ARTIFACTORY_LOCATION=${GROUP_ID//.//}
echo "export artifactory_path=$ARTIFACTORY_LOCATION" >> $VARIABLE_FILE
echo ARTIFACT_ID=$(mvn help:evaluate -Dexpression=project.artifactId -q DforceStdout)
echo "export project_name=$ARTIFACT_ID" >> $VARIABLE_FILE
export PROJECT_NAME_LC=`echo $ARTIFACT_ID | awk '{print tolower($0)}'`
echo "export project_name_lc=$PROJECT_NAME_LC" >> $VARIABLE_FILE
APP_VERSION=$(mvn help:evaluate -Dexpression=project.version -q DforceStdout)
export APP_VERSION=$APP_VERSION
export tag_version=$(awk -F- '{print$1}' <<< $APP_VERSION)
now=`date +'%Y%m%d%H%M'`
git --version
echo "************prtining branch*************"
echo "GITHUB_REF_NAME : "
echo $GITHUB_REF_NAME

if [ $GITHUB_REF_NAME == 'main' ]
then
    echo "export version=$tag_version" >> $VARIABLE_FILE
    echo "export artifactory_type=$ARTIFACTORY_RELEASE" >> $VARIABLE_FILE
elif [$GITHUB_REF_NAME!=null]
then
    echo "deploying tag: $GITHUB_REF_NAME"
    echo "export version=$tag_version" >> $VARIABLE_FILE
    echo "export artifactory_type=$ARTIFACTORY_RELEASE" >> $VARIABLE_FILE
else
    echo "export version=$APP_VERSION" >> $VARIABLE_FILE
    echo "export artifactory_type=$ARTIFACTORY_SNAPSHOTS" >> $VARIABLE_FILE
fi

ls -al
echo "******************reading VARIABLE_FILE start*****************"
cat $VARIABLE_FILE
echo "******************reading VARIABLE_FILE end*****************"


# echo "::set-output name=output_file::$VARIABLE_FILE"