From: Steve Harris <S.W.Harris=jaJdc+oKuOm+cE1VCfRBVw@public.gmane.org>
Subject: Re: novation remote 25 usb midi controller
Date: Thu, 31 Jul 2003 09:15:18 +0100
Sender: linux-audio-user-admin=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20030731081518.GC10473@ecs.soton.ac.uk>
References: <3F288002.214F08C9@zhevny.com>
Reply-To: linux-audio-user=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-audio-user-admin@music.columbia.edu>
Content-Disposition: inline
In-Reply-To: <3F288002.214F08C9@zhevny.com>
Errors-To: linux-audio-user-admin@music.columbia.edu
List-Help: <mailto:linux-audio-user-request@music.columbia.edu?subject=help>
List-Post: <mailto:linux-audio-user@music.columbia.edu>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request@music.columbia.edu?subject=subscribe>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user/>
To: linux-audio-user <linux-audio-user=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, "alsa-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <alsa-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 30, 2003 at 10:33:38 -0400, Eric Dantan Rzewnicki wrote:
> lsusb returns nothing and there is nothing in /proc/bus/usb/devices (
> which I
> guess says the same thing. ) 

Do you mean absolutly nothing, or just no MIDI devices? I always see
the system hubs and bridges and so on.
 
> ./configure --with-cards=ice1712,usb-audio --with-sequencer=yes
> --with-oss=no

I'l be usb-midi, not usb-audio.

- Steve 
