From: Melchior FRANZ <mfranz@aon.at>
Subject: cvs/head -- malign changes since v1-0-7
Date: Fri, 10 Dec 2004 18:17:32 +0100
Message-ID: <200412101817.32986@pflug2.gphy.univie.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

FYI: I'm running alsa as included in Linux 2.6.9 on x86 (SuSE 9.2).
When I install alsa-lib from cvs/head, the system starts to use
around 40% of the cpu performance after having played some sound.
("top" doesn't show any responsible process -- it's the system.)
Only "rcalsasound restart" stops the CPU cycle burning. This doesn't
happen with v1-0-7.

m.
 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
