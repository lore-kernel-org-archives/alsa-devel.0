From: "Luuk van Dijk" <lvd@mndmttr.nl>
Subject: =?utf-8?Q?=22soft=22?= spdiff support
Date: Mon, 15 Nov 2004 17:21:13 +0100
Message-ID: <courier.4198D779.00011623@outpost.mndmttr.nl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

LS. 

I am currently writing a driver for the ADI 1836 on the (ongoing) 
blackfin/uclinux port (blackfin.uclinux.org) and I have some questions (that 
I'll post in separate mails, so that they may be separate threads) 

With this particular hardware configuration, I have access to a 'raw' 
sp/diff datastream through a PCM channel.  is there a generic sp/diff 
encaps/decaps layer in the ALSA driver?  Are there maybe other (eg userland) 
software implementations of this? 

otherwise: is it hard to write/can anyone send me a pointer to a public 
version of the spec? 

Thanks,
  Luuk


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
