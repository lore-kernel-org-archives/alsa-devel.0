From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Metering on record
Date: Mon, 29 Sep 2003 22:22:45 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030929222245.6d5260f8.erikd-alsa@mega-nerd.com>
References: <20030928121741.45922701.erikd-alsa@mega-nerd.com>
	<Pine.LNX.4.53.0309291033310.1362@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309291033310.1362@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Sep 2003 10:37:56 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> The examples are in alsa-lib/src/pcm/scopes directory, but don't expect
> a better response times, because the meter plugin is also activated
> when an application reads or writes data to device.

Does that mean that the only way to get better meter response is to
read smaller blocks?

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"The day Microsoft makes something that doesn't suck is probably the
day they start making vacuum cleaners." -- Ernst Jan Plugge


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
