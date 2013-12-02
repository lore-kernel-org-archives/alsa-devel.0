From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Mon, 02 Dec 2013 13:22:42 -0800
Message-ID: <529CFA22.1050705@gmail.com>
References: <529BF843.6000608@gmail.com> <529CAE8D.6020003@zonque.org>
 <529CB1F6.7070607@gmail.com> <201312021948.58167.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 173EE264F2C
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 22:22:45 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id up15so19761901pbc.24
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 13:22:44 -0800 (PST)
In-Reply-To: <201312021948.58167.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>, alsa-devel@alsa-project.org
Cc: Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/02/2013 11:48 AM, Alan Horstmann wrote:
>> But solving this required editing asoundrc files (ugh) and casting
>> several magic spells.  Would be nice if it "just works."
>
> The same problem occurs with Portaudio on this device (or similar) - it would
> be great to just be able to open one device with 4 channels, or 2 stereo
> pairs.
>
> I had wondered whether it could be done by some card-specific definitions in
> eg /usr/share/alsa/cards as is done particularly with PCI cards??  Anybody
> any ideas?

Good idea.

>
> Gabriel, could you post the multi pcm you worked out for this, as it may help
> others?

I can't take credit for figuring it out.  Got it from here:

http://ywwg.com/wordpress/?p=772

-gabe
