From: Daniel Mack <daniel@caiaq.de>
Subject: Re: using snd_usb_audio module
Date: Sat, 8 May 2010 12:45:21 +0200
Message-ID: <20100508104521.GK30801@buzzloop.caiaq.de>
References: <s2z6e8e83e21005080109s3b7be543r121ed4daaa712a3c@mail.gmail.com>
	<20100508095407.GH30801@buzzloop.caiaq.de>
	<v2n6e8e83e21005080336r3a861efdh3e434eed2efa5837@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D8952460E
	for <alsa-devel@alsa-project.org>;
	Sat,  8 May 2010 12:45:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <v2n6e8e83e21005080336r3a861efdh3e434eed2efa5837@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bee Hock Goh <beehock@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 08, 2010 at 06:36:42PM +0800, Bee Hock Goh wrote:
> I wish to output the audio of a tv card as a usb audio interface.

So you want your Linux box to be a USB audio peripheral? That's possible
using the audio gadget driver, but I've never done that, so I can't help
much.

However, what you're trying to do doesn't have anything to do with
snd_usb_audio.


Daniel


> 
> On Sat, May 8, 2010 at 5:54 PM, Daniel Mack <daniel@caiaq.de> wrote:
> > On Sat, May 08, 2010 at 04:09:18PM +0800, Bee Hock Goh wrote:
> >> I wish to make use of snd_usb_audio in my module. Is there a good
> >> document/tutorial or reference codes that I get kick-started on?
> >
> > What module are you talking about? What exactly are you trying to do?
> >
> > Daniel
> >
