From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.13 and hdsp cardbus
Date: Fri, 6 Oct 2006 18:09:59 +0400
Message-ID: <70a871c80610060709s73c87f03u31f4e91af077da46@mail.gmail.com>
References: <70a871c80610050541r73bbc2d7j408595802bb2c43f@mail.gmail.com>
	<4525F73D.2040105@chello.at>
	<70a871c80610060027l4196fdfi7b7ecd215733a7b3@mail.gmail.com>
	<45264A94.6010504@chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45264A94.6010504@chello.at>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Karl Grill <kgrill@chello.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/6/06, Karl Grill <kgrill@chello.at> wrote:
> Thanks a lot, but is it possible that you made a mistake in writing this
> down?
> Namely, this looks suspicious:
> > lspci gives:
> > 02:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
> > DSP (rev 35)
> rev should be either 15 or 53 (to my knowledge)
No, it is 35. Definetely.

> and find a windows box where you can do it). Otherwise, wait for an
> update of the alsa driver; I'm working on it, but it will take some time
> (Christmas?)

It worked ok with linux-2.6.17 and alsa-driver-1.0.11

Regards,
Dmitry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
