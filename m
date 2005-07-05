From: w3sz@comcast.net
Subject: ALSA Delta44 ice 1712 bug
Date: Tue, 05 Jul 2005 11:58:38 +0000
Message-ID: <070520051158.25328.42CA75EE000904DA000062F02205886014969CCC99@comcast.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hello,

I have found and numerous others have confirmed that the Maudio Delta-44 does not function properly under ASLA when 96000 Hz sampling of the input stream is attempted.

This issue has occurred with a variety of different Linux installations.  

I have noticed it with Debian-Sarge [3.1] and also with Knoppix 3.8.0, 3.8.1, and 3.9.2, using several different kernel versions up to and including 2.6.11.11.

The hardware showing this behaviour has been varied, from P3 1 GHz thru P4 3.2 GHz with Hyperthreading.

This has been so commonly reported that I was surprised to not see it on your known bugs page, at:  http://www.alsa-project.org/alsa-doc/doc-php/bugs-full.php.

Thank you,

ROger Rehr


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
