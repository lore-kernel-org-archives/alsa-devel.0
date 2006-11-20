From: Nicolas Boullis <nboullis@debian.org>
Subject: Re: Where is /usr/share/alsa/cards/?
Date: Tue, 21 Nov 2006 00:16:58 +0100
Message-ID: <20061120231657.GF3695@home>
References: <20061118210734.GE9190@home> <s5h1wnys806.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1wnys806.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Mon, Nov 20, 2006 at 11:54:49AM +0100, Takashi Iwai wrote:
> 
> I don't think there is no proper way to detect the path.

OK, too bad. :-(


> In addition, you can add an automatic search of the path
> (i.e. checking /usr/share/alsa/alsa.conf, /etc/alsa/alsa.conf, ...)
> in configure script.

That'd certainly be nice, but I should first learn how to write complex 
configure scripts... ;-)



Thanks,

Nicolas

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
