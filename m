From: barat@medien.uni-weimar.de
Subject: Re: mmaped play in multichannel mode (fwd)
Date: Thu, 31 Jul 2003 10:31:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0307311027360.14824@spring>
References: <200307302036.h6UKaJ6p001930@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307302036.h6UKaJ6p001930@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Jul 2003, Paul Davis wrote:

> >i guess that outbuffer has a wrong size. does somebody have any idea about 
> >this outbuffer calculation?
> 
> i don't know exactly why you're spending time doing this. whether you
> decide to use it or not, JACK (http://jackit.sf.net/) has full,
> working code that shows how to do this. but i'd personally recommend
> that you consider using it instead of reinventing the wheel, etc.
> 

im indeed working on using jack as another audio-out, but at first i 
wanted to improve the existing alsa-out. but thanks anyway.

joy


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
