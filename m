From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: [Alsa-user] New Echoaudio firmware - testers wanted for Layla
 3G (3rd attempt)
Date: Tue, 6 Dec 2005 16:03:59 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0512061600500.8563@denise.shiny.it>
References: <20051205202000.6a58f7af.pochini@shiny.it>
 <200512061537.32273.conrad.berhoerster@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200512061537.32273.conrad.berhoerster@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: conrad =?iso-8859-1?q?berh=F6rster?= <conrad.berhoerster@gmx.de>
Cc: alsa-user@lists.sourceforge.net, Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



On Tue, 6 Dec 2005, conrad [iso-8859-1] berh=F6rster wrote:

> after running alsaconf, there is a card detected V8237 with VT1616i
> is this ok?

No, this is probably the soundchip integrated in you motherboard.


> DO i need to copy some more files to some place, maybe the firmware from =
the
> CD.

No, you need alsa-driver and alsa-firmware. Maybe you have try the beta
version I announced.


> and how can i make sure, if i have the hotplug scripts or i need to updat=
e
> them. the link from your website had no readme and lots of different
> programs, which one do i need.

These are the latest stable alsa with the changes I wrote about. More info
on how to make it work are here:  http://www.webalice.it/g_pochini/ead/


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
