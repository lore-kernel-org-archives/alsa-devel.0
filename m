From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: pcm devices with alsa in emu10k1 audixy
Date: Sun, 10 Feb 2002 10:20:19 +0100 (MET)
Message-ID: <a45ekm$282$1@quimby2.netfonds.no>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hallo list

I am still used to uss, there i was able to
cat data to /dev/dsp and it sounded.
I have no problem with the fact that no i have many seperate devices with my
emu10k1 audixy card from creative, bit when i cat data to this device,
'cat' says that the file descriptor is in a bad state.
Can anybody help me ?

apart from this, If I use aplay, i can select several Devices with -D

possible options i found out are hw, default and some others.
What do they mean ?
Is it possible to output on the rear speakers ?
I dont understand the output of -L at all.
How can I select a device outputted with -l ?

rds guenther


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
