From: Allan Klinbail <allank@labyrinth.net.au>
Subject: latency with mtpav
Date: 23 Jun 2003 23:07:44 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1056373664.15797.11.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Alsa-dev <alsa-devel@lists.sourceforge.net>
Cc: Alsa-user <alsa-user@alsa-project.org>, MusE list <muse@seh.de>, ardour-dev <ardour-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi

(sorry for the crossposting but I'm not sure where this one should go) 

In trying to test various applications with sync I have observed some
serious latency problems with the mtpav driver.

Using ardour I found some serious latency when starting a recording
(about half a beat at 163.7 BPM (sorry the calculations escape me trying
to work out the exact latency here))

Has any9one else experienced this or can come up with a resolution for
this.. 

(No xruns were observed by wither MusE or JACK while doing this test) 

cheers




-- 
Allan Klinbail <allank@labyrinth.net.au>



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
