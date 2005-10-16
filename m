From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Soundcard matrix update - Echoaudio
Date: Sun, 16 Oct 2005 16:05:41 +0000
Message-ID: <20051016160541.29f34177.pochini@shiny.it>
References: <20051015191158.37e0f620.pochini@shiny.it>
	<2c746f620510151456u3d40181bi1de819300e8f85e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620510151456u3d40181bi1de819300e8f85e3@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Shattow <lucent@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 15 Oct 2005 16:56:03 -0500
Eric Shattow <lucent@gmail.com> wrote:

> Would you like to write driver support for the Echo AudioFire series
> of hardware? I contacted a guy at Echo who seemed positive about
> providing information necessary. If you write the driver, I will do my
> best to provide you with hardware to test it on (this means contacting
> echo for a sample unit, or even funding one from my own pocket).

I may write the driver for the new FW cards, but take into account that I
work on it in my spare time, a driver for a fw soundcard is very different
than the PCI driver, and I cannot say how much time I can take to write it.
The Freebob project http://sourceforge.net/projects/freebob/ is (very
slowly) developing drivers for FW cards but it's still alpha version and it
supports only cards with the AV/C command set (so says the page above, no
idea what is it). Furthermore, I have to learn how to talk with the card
kernel-side from scratch and without tutorials..

--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
