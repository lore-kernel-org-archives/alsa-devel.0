From: "M. Nentwig" <nentwig@users.sourceforge.net>
Subject: Hammerfall HDSP multiface doesn't work with latest driver?
Date: Tue, 27 May 2003 11:56:42 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED3284A.FE3C1AF3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I just compiled alsa-lib and alsa-drivers yesterday. Now my hammerfall
hdsp multiface doesn't load the firmware anymore. The red LED remains
on, 'modprobe' ends with 'waiting for firmware'.
I reverted to an earlier version of alsalib and alsadrivers, and it
works again. Any ideas?

Regards

Markus



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
