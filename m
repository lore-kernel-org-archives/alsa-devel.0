From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Azalia/ICH6-HDA mixer support?
Date: Thu, 25 Nov 2004 12:44:31 +0100
Message-ID: <200411251144.iAPBiVIP006401@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
To: SWarren@nvidia.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

AFAIK AZX driver is new (this is why it is in alsa-driver and not in
alsa-kernel). Mayby it is not finished.

For codec info try this (from azx.txt).

cat /proc/codecinfo > info.xml && mozilla file://'pwd`/info.xml=20

Peter Zubaj

=0A____________________________________=0Ahttp://www.pobox.sk/ - najvacsi s=
lovensky freemail=0A=0A=0A


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
