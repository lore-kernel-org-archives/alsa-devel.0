From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: General Info. PCI Audio devices that are handled by the OpenSound
 OSS drivers, but not handled by ALSA.
Date: Wed, 12 May 2004 05:30:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A1A873.8090304@superbug.demon.co.uk>
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

Just for general info.
This list is a lot longer than I expected.
This list only includes PCI devices.
This list only includes devices that ALSA does NOT support currently.

PCI AUDIO DEVICES handled by OSS but not ALSA.
pci-id, comment, oss binary module name.
pci4005,308 NOT-HANDLED "als300"
pci1023,2002 NOT-HANDLED "wave4d"
pci1073,5 NOT-HANDLED "ymf724"
pci1078,103 NOT-HANDLED "geode"
pci10b5,1142 NOT-HANDLED "lynxone"
pci10c8,8016 NOT-HANDLED. "neomagic"
pci1102,6 (New Dell SB Live, ALSA support just posted. )
pci1102,7 NOT-HANDLED, (SB Audigy LS)
pci1106,7059 NOT-HANDLED "via8233"
pci1274,8001 NOT-HANDLED "apci97"
pci1274,8002 NOT-HANDLED "apci97"
pci1412,3630 NOT-HANDLED "envy24ht"
pci1412,d630 NOT-HANDLED "envy24"
pci1412,d631 NOT-HANDLED "envy24"
pci1412,d632 NOT-HANDLED "envy24"
pci1412,d633 NOT-HANDLED "envy24"
pci1412,d634 NOT-HANDLED "envy24"
pci153b,1115 NOT-HANDLED "envy24"
pci153b,112b NOT-HANDLED "envy24"
pci153b,1130 NOT-HANDLED "envy24"


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
