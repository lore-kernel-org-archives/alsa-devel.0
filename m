From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] udev: Access permission of fw character device in
 which fw node includes unit handled by ALSA
Date: Tue, 18 Jun 2019 09:35:58 +0930
Message-ID: <20190618000558.GB20102@marvin.atrad.com.au>
References: <20190520122724.GA14864@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20190520122724.GA14864@workstation>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux1394-devel>,
 <mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
 <mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: systemd-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Mon, May 20, 2019 at 09:27:27PM +0900, Takashi Sakamoto wrote:
> I'm an ALSA developer, mainly committing to drivers for audio and
> music units on IEEE 1394 bus (yes, it's legacy FireWire). I have a
> concern about access permission for fw character device.
> :

This was CCed to the FFADO-devel list.  My linux boxes don't use systemd and
I have only a superficial picture of systemd, so I don't think I can offer
any suggestions.  Furthermore, FFADO ships a collection of udev rules which
seem to do the job for FFADO regardless of whether systemd is used or not. 
Consequently it appears that the above discussion is not directly relevant
to FFADO.

If there are connections I'm not aware of please fill me in and I'll respond
accordingly.

Regards
  jonathan
