From: Jesper Lykke Petersen <lykkedk@web.de>
Subject: M-Audio revolution 7.1 DAC,0 to DAC,1
Date: Sun, 09 Nov 2003 10:19:00 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1068373139.1820.7.camel@lykke>
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

Hi I was hoping someone could tell me howto change the ALSA 0.9.8 src,
so that all changes to DAC,0 automatic will be mapped to DAC,1.

I'am using the snd-ice1724 

My problem is, that this card have no "Master", only theese DAC's to
change volume.

So i can only change eg. LEFT (DAC,0) in xmms at the time.

I read this about the snd-ice1712 which is another envy-based card..

http://opensrc.org/alsa/index.php?page=Mapping+oss+mixer+controls+to+alsa+mixer

So i think it could be done on my ice-1724 too... just don't now howto 

I'am no programmer, but i can sure change something in my ALSA-src and
recompile it.

Thanx in advance... Jesper





-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
