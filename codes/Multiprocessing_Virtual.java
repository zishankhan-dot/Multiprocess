import java.util.ArrayList;
import java.util.List;

class Multiprocessing_Virtual {
    
    public static void main(String[] args) throws Exception {
        int tasks = 100000;
        ArrayList<Thread> threads = new ArrayList<>();

        for (int i =0; i<tasks;i++){
        Thread t = Thread.ofVirtual().start(() -> {
            try {
                Thread.sleep(100);
            } catch (Exception e) {
                System.out.println(e);
            }
        });
            threads.add(t);
        };
        for (Thread thread: threads) {
            thread.join();
        }


    }
}   