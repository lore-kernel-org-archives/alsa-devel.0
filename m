From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: difference between OSS mmap and alsa mmap?
 [alsa-oss]
Date: Tue, 24 Aug 2004 14:20:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040824142011.47a2b82a@mango.fruits.de>
References: <20040705144251.6a286c94@mango.fruits.de>
	<200407051313.i65DDlH7023180@localhost.localdomain>
	<s5hvfh27fr6.wl@alsa2.suse.de>
	<20040824135710.2422ef23@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040824135710.2422ef23@mango.fruits.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Aug 2004 13:57:10 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> btw: i might prove my ignorance with this question, but i have to ask:
> 
> what makes the kernel oss emu handle mmap so good? it's an emulation,
> too, i suppose.. so what is the big difference in these two
> emulations, that in one case it works well [kernel oss emu] and in the
> other it seems almost impossible [libaoss.so]..
> 

besies the, of course, obvious fact that one lives in kernel space and
the other in user space..

flo


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
