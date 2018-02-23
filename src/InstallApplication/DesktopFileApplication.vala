using Snapd;

namespace Application {
public class App {

    private static Client client; 

    public static int main(string[] args) {

        client = new Snapd.Client();

        if (!client.connect_sync (null)){
            stdout.printf("Could not connect to snapd");
            return 0;
        }
        
        string option = args[1];
        string name = args[2];

        if(option == "remove"){
           deletePackage(name);
           return 0;
        }

        if(option == "install"){
           installPackage(name);
           return 0;
        }

        if(option == "update"){
           updatePackage(name);
           return 0;
        }

        return 0;
    }

    public static void deletePackage(string name) {
        try{
            client.remove_sync (name,null, null);
        } catch (SpawnError e) {
            stdout.printf(e.message);
        }
    }

    public static void installPackage(string name) {
        try{
            ProgressCallback progress;

            client.install2_sync (InstallFlags.CLASSIC, name, null, null, (client, change) => {
            //GLib.GenericArray<weak Snapd.Task> array = change.get_tasks();

            //array.foreach ((Task) => {
                //stdout.printf(Task.id);
            //});

            //stdout.printf(array.length/2).to_string() + "\n");
            //stdout.printf(change.get_status() +"status\n");            
            stdout.printf(change.get_status() +"status\n");
            //stdout.printf(change.get_summary() +"summary\n");
		});
        } catch (SpawnError e) {
            stdout.printf(e.message);
        }
    }

    public static void updatePackage(string name) {
        try{
            client.refresh_sync (name, null, null, null);
        } catch (SpawnError e) {
            stdout.printf(e.message);
        }
    }
}
}

