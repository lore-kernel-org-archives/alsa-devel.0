From: Ville =?iso-8859-1?Q?P=E4tsi?= <drc@gimp.org>
Subject: Re: Miditech Midistart-2 USB keyboard
Date: Mon, 9 Aug 2004 11:19:25 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040809081925.GA2203@torni>
References: <20040806231819.GB2309@torni> <Pine.HPX.4.33n.0408090953400.11985-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0408090953400.11985-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

These 0.8K bytes were from Clemens Ladisch,
> Ville Pätsi wrote:
> > What is needed to get snd-usb-audio to support this?
> >
> >   idVendor           0x7104
> >       bInterfaceClass         2 Communications
> >       bInterfaceSubClass      1 Direct Line
> 
> This is a modem made by Philips.  I'm not really sure if snd-usb-audio
> should support this device ...  ;-)
> 
> Miditech's vendor ID is 0x4752.

Well then something fishy is going on, since the keyboard is reporting
that on both computers I have, and the windows driver has no problems.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
