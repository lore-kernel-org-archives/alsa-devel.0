From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: UDA1341TS (iPAQ H3X00) sound driver for ALSA
Date: Fri, 12 Apr 2002 18:35:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a9763a$j1g$2@main.gmane.org>
References: <D99C1FB421989A40818B6370E31870940283ADF3@tayexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <D99C1FB421989A40818B6370E31870940283ADF3@tayexc19.americas.cpqcorp.net>; from Jamey.Hicks@compaq.com on Wed, Apr 10, 2002 at 09:55:43AM -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "Hicks, Jamey" <Jamey.Hicks@compaq.com>
Cc: Nicolas Pitre <nico@cam.org>, Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>, alsa-devel@lists.sourceforge.net, Linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 10, 2002 at 09:55:43AM -0400, Hicks, Jamey wrote:
> > -----Original Message-----
> > From: Nicolas Pitre [mailto:nico@cam.org]
> > 
> > No.  Please pick a relevant name.  H3600 is not the only 
> > device with an UDA1341 out there.
> 
> The alsa driver mentioned is iPAQ specific.  It would be useful to
> restructure it in the way the other SA11x0/UDA134x driver is structured.

I agree with Nico.  Nico is objecting to it being called *h3600* when it
is for all iPAQs, ie, H3600, H3100, H3800.
