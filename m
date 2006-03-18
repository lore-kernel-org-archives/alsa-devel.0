From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] nearest conv_rates matching
Date: Fri, 17 Mar 2006 19:04:20 -0500
Message-ID: <1142640261.25258.137.camel@mindpipe>
References: <20060317235714.50540.qmail@web38612.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060317235714.50540.qmail@web38612.mail.mud.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "S. Effendi" <osbebas@yahoo.co.id>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-03-18 at 06:57 +0700, S. Effendi wrote:
> Hi all,
> 
> attached you can find a simple patch to match
> "uncommon" rate in some USB speaker to the fixed
> conv_rates in usbaudio.c.

So it just plays the file off-speed?  Or is the device reporting a wrong
sample rate?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
