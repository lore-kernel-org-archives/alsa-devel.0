From: "Vladimir I. Umnov" <uvi@ezmail.ru>
Subject: Re: channels problem for soundstorm
Date: Wed, 10 Dec 2003 20:10:40 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031210201040.0d630449.uvi@ezmail.ru>
References: <200312101350.21440.midall@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312101350.21440.midall@tiscali.it>
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

On Wed, 10 Dec 2003 13:50:21 +0100
Midall <midall@tiscali.it> wrote:

> Hi at all, i have abit nf7-s with nforce soundstorm mcp-t
> I use the latest alsa lib, dev, tool (1rc2) all are ok but when i play
> a dvd the channels are inverted and result effect is like ping-pong
> channel to channel..
> I have connetc analog kit 5.1 (logitech z-640) to sk audio in
> center/sub jack, front right+left, rear right+left.. suggest me the
> perfect configuration for the mixer....
> sorry for my english i'm italian
> Thanks and bye
This problem is in drivers or may be in mcp-t too. Under windows I have
the same problem while seeking, but under windows latency is much lower
and sheduler is better (only for multimedia applications) and xrun
doesn't appear.
It's useless write to this list, becouse developers doesn't have such
'expensive' hardware and they time is 'costly'. I try to get help
before, and nobody give me a correct answer. And this topic was
forgotten.

May be nvidia must do something? And with nvidia drivers xrun happens
much more easy.
And I think before buying such hardware, that nvidia do a revolution,
but they rob all thechnologies from another existing products with all
bugs and add amount of bugs "from nvidia developers" (I mean dual
channel from intel, ide from amd, sound from i810, and so on).




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
