From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 15:26:01 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020918152601.A2654@sci.fi>
References: <Pine.LNX.4.33.0209181054350.534-100000@pnote.perex-int.cz> <20020918120235.49273.qmail@web40601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020918120235.49273.qmail@web40601.mail.yahoo.com>; from rankincj@yahoo.com on Wed, Sep 18, 2002 at 01:02:35PM +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 18, 2002 at 01:02:35PM +0100, Chris Rankin wrote:
> So maybe we could have a --with-compat-rc3 option for
> alsa-utils as well?

I don't think there has been any other changes. Just use rc3 alsa-utils.

> And I doubt that wine and xine will get updated before
> -rc4 is released.

> (Unless there's a document somewhere
> explaining the relationship between the old and new
> API functions, in which case I could submit patches
> myself.)

As I understand it the change was pretty trivial. Just compare the header
files or aplay for example. Or just don't use the latest cvs stuff.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
