From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: changes in behaviour of mtpav
Date: 05 Mar 2003 23:53:38 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046868819.8933.21.camel@littlewolf2.littlewolf>
References: <1046663477.2146.68.camel@littlewolf2.littlewolf>
	<s5hadgclcry.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadgclcry.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Even stranger then .. when I did my last CVS update.. the mtpav driver
was one that did update... that is why I rechecked behaviour.. however I
did not use the panic button last time .. so maybe I am at fault

On Tue, 2003-03-04 at 01:56, Takashi Iwai wrote:
> At 03 Mar 2003 14:51:15 +1100,
> Allan Klinbail wrote:
> > 
> > 
> > 
> > Hi 
> > 
> > I upgraded my CVS of alsa today and noticed some changes in the behaviou
> > of the mtpav driver.. 
> > 
> > On first startup of the device, everything worked perfectly... on the
> > second and susbsequent I observed no output from the device .. until I
> > hit the panic button.. 
> 
> strange, the driver has not been changed since you tested at last
> time...
> 
> > 
> > after hitting the panic button everything (output wise) seemed to work
> > well.
> > 
> > I will do a full test of input and recording over the next couple of
> > days. 
> 
> atm i'm overloaded, so the hack/fix for mtpav will be delayed.
> sorry.  it will be likely after the 0.9.0-final is released.
> 
> 
> Takashi




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
