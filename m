From: Peter Enderborg <pme@ufh.se>
Subject: Number of subdevices on midi.
Date: Wed, 03 Apr 2002 21:23:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CAB5699.1927A89D@ufh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have tryed to get some answer from Jaroslav about subdevices on midi.
Im trying to write
a driver for midisport 8x8/s and that have 9 midi ports. On my hack to
figure out
the protocol I use virmidi to handle the interface to alsa. But virmidi
only have four
subdevices per device. I need to see the driver for a midi interface
that using all the
16 subdevices. Since I don't get answer from Jaroslav i guess he don't
have the time
or my question is stupid. But can someone help me out? Where should I
look?
