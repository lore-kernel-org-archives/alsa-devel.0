From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: installing alsa
Date: Tue, 3 Dec 2002 11:40:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021203104000.GA1133@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

I found the snddevices scripts in alsa-drivers.  Sorry for
posting. Maybe it's a good idea to include it in an install script?

BTW: Make uninstall in alsa-drivers just removes
/lib/modules/kernel/sound/drivers/snd-*, but doesn't remove the hdsp
and hammerfall-mem modules as they are in another subdirectory.

--
Orm


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
