From: Francisco Moraes <fmoraes74@netzero.net>
Subject: Help with supporting Emu10k1x  and question
Date: Mon, 16 Feb 2004 18:39:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403154C2.3020701@netzero.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am trying to get the Emu10k1x chip supported in alsa. Anyone willing 
to give me a hand, please email me. I've got a few register dumps and I 
am trying to get it working.

Now for the question, I tried to add a snd_printk() call to the 
pci/emu10k1/io.c ptr_write function, but it causes the system to hang. 
Is there any alternative to that?

Thanks,

Francisco



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
