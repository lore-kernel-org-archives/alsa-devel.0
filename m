From: Alftheo Potgieter <alfp@adsmr.co.za>
Subject: SBLive 3d Positioning
Date: Wed, 25 Sep 2002 13:23:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D919CA5.5040700@adsmr.co.za>
References: <E17u0ih-00042S-00@usw-sf-list2.sourceforge.net>
Reply-To: alfp@adsmr.co.za
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

Does anybody know how to use the 3D positioning feature of the SB Live 
card? I want to place a number of individual sounds in space.

According to the ac97 spec, register 0x22 has bits for depth and center, 
which would do what I want, but the STAC9708 only has audio 
'separation', which does not sound like specifying a position.

Is the EMU10K1 and the STAC9708 two separate devices, or is it two 
interfaces to the same underlying hardware?

alf



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
