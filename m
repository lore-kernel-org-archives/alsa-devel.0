From: Christof Damian <cdamian@guideguide.com>
Subject: Re: Hoontech Audio DSP24 Value (+bracket)
Date: Tue, 12 Feb 2002 16:37:52 +0000
Message-ID: <20020212163752.C18197@stratus.london.guideguide.com>
References: <0000723B.3C693976@oz.ridi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000723B.3C693976@oz.ridi.com>; from claus@ridi.com on Tue, Feb 12, 2002 at 02:49:33PM +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: claus@ridi.com
Cc: alsa-devel@alsa.alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 12 Feb 2002, claus@ridi.com wrote:
>
> It is not possible to distinguish between a DSP24 Value and a DSP24
> card in software. Also you cannot detect the converter on the card
> (as it is not needed).

so it would be necessary to specify the type of card and/or number of
boxes when the driver loads ?

> > The DAC & ADC volume don't seem to work though.
> 
> The hardware does not provide any function to change the input or
> output level of the analog I/O.

bugger. but the AK4524 supports changing the input gain, doesn't it ?

christof
-- 
Christof Damian         
Technical Director, guideguide ltd.	            

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
