From: Jussi Laako <jussi.laako@pp.inet.fi>
Subject: Delta1010 lockup
Date: Tue, 03 Feb 2004 22:54:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1075841695.3498.4.camel@vaarlahti.uworld>
Mime-Version: 1.0
Content-Type: text/plain
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

Playback from xmms using ALSA output plugin and plughw channels 8&9
(S/PDIF). Record 2 channels from plughw channels 0&1 (analog 1&2). ->
hard lockup

Same thing works with OSS, so this is not hardware issue. Any ideas?

alsa-driver-1.0.2b
alsa-lib-1.0.2


-- 
Jussi Laako <jussi.laako@pp.inet.fi>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
