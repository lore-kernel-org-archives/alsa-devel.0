From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: List of control parameters needed
Date: Mon, 22 Mar 2004 12:52:38 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403221246590.5648@denise.shiny.it>
References: <003701c40fff$1e875800$f8b6a8c0@ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <003701c40fff$1e875800$f8b6a8c0@ent.ti.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pavana Sharma <pavans@india.ti.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Mon, 22 Mar 2004, Pavana Sharma wrote:

> Hello,
>
> I  am trying to export the controls to user space. I want to know the
> complete list of controls
> [...]
> Where can I get the complete list of controls which an audio codec has
> to support.

There is not such a list because they depend on the hardware. But there
is a list of common names that all drivers should respect.
The list is: /alsa-kernel/Documentation/ControlNames.txt


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
