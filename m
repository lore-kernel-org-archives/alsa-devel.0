From: Mark Constable <markc@renta.net>
Subject: Minor issue with /proc/bus/pci/devices
Date: Mon, 22 Jul 2002 20:56:50 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3BE4F2.7030303@renta.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

# cat /proc/bus/pci/devices
... EMU10K1/Audigy ...

The above may be intended but I have an older SBlive and certainly not
an Audigy.

# grep "ultimedia" /proc/pci
     Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 5).

--markc



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
