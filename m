From: Christian Guggenberger <Christian.Guggenberger@physik.uni-regensburg.de>
Subject: Re: oops while unloading snd-intel8x0
Date: Tue, 10 Dec 2002 19:53:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021210195350.A10204@pc9391.uni-regensburg.de>
References: <20021204153112.C998@pc9391.uni-regensburg.de> <20021209202452.G6137@pc9391.uni-regensburg.de> <20021210135031.G31605@pc9391.uni-regensburg.de> <s5hy96x7ruc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy96x7ruc.wl@alsa2.suse.de>; from tiwai@suse.de on Tue, Dec 10, 2002 at 17:37:31 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10.12.2002   17:37 Takashi Iwai wrote:
> Hi,
> 
> At Tue, 10 Dec 2002 13:50:31 +0100,
> Christian Guggenberger wrote:
> >
> > Hi,
> >
> > I get following oops while unloading snd-intel8x0 on a Dell Optiplex 260
> > Kernel is 2.4.20aa1 (happens again with plain 2.4.20)
> > Alsa is 0.9.0rc6 (and CVS 20021204)
> > Debian/woody.
> 
> hmm, it's a new type of oops, which i've never seen.
> 
> could you trace at which point this happens, for example, by adding
> buch of printk()s ?
> 

sorry, but I don't have much knowlegde about kernel/module programming. I 
really don't know where to start for this...(okay, I know this is a developers 
list, but my mail to alsa-user got no repsonse:)

Maybe you, or anyone else, could post a patch to get more debugging 
information out of that oops?

thanks
Christian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
