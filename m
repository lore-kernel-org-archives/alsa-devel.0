From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
 (Summary)
Date: Sun, 28 Sep 2003 21:31:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F77450A.8070302@superbug.demon.co.uk>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com>	<s5hllt8oaye.wl@alsa2.suse.de>	<3F535A42.6020403@icem.com>	<s5hekz0o7wi.wl@alsa2.suse.de>	<3F536C97.5080008@icem.com>	<s5hbru4o444.wl@alsa2.suse.de>	<3F538893.1010801@icem.com> <s5h7k4snyhl.wl@alsa2.suse.de> <3F539A3E.3030508@icem.com> <3F53B38B.6070307@icem.com> <3F75D029.60502@icem.com> <3F77395B.8080208@icem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F77395B.8080208@icem.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carsten Koch <Carsten.Koch@icem.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Carsten Koch wrote:
> I forgot two more things:
> 
> 1) If there is anything else you would like me to try out or any
>    additional information from that system, I will be glad to help.
> 
> 2) Is anyone else having similar problems?
>    Is it just me or do other nforce2 users also have the feeling
>    that Alsa supports IEC958 much, much better on the CMI8738
>    than on nforce2?
> 
> Thanks again and Cheers,
> 
> Carsten.
> 
I think it basically comes down to lack of documentation about the chips.
The sound cards that work well in linux have one of two things: -

1) good specification documents.
A lot of manufactures seem to publish specification documents for their 
chips, but very few of these published documents are complete and 
accurate. I have not found any AC97 chip yet that has full details on 
how to set non-audio bits on the SPDIF, although the chip manufacturer 
has published specification documents for the chip. E.g. Realtek ALC650.

2) Someone with the time to tinger about and discover how to do it.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
