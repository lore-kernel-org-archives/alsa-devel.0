From: Damien Sandras <dsandras@seconix.com>
Subject: SND_PCM_OPEN_PLAYBACK & SND_PCM_OPEN_CAPTURE
Date: 13 Aug 2003 12:05:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060769104.18854.2.camel@linuxzone>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I would like to know if it is always possible to open the same device
twice at the same time : once with SND_PCM_OPEN_PLAYBACK and once with
SND_PCM_OPEN_CAPTURE.

I know it is not possible with OSS, but I wanted to know if ALSA makes
it possible or if the device has to be opened only once with
SND_PCM_OPEN_DUPLEX in that case.

Thanks a lot!
-- 
Damien Sandras <dsandras@seconix.com>



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
