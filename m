From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Turtle Beach Pinnacle/Fiji
Date: Sun, 26 May 2002 20:02:35 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020526200235.A4686@sci.fi>
References: <20020525115104.76315.qmail@web12201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020525115104.76315.qmail@web12201.mail.yahoo.com>; from annabellesgarden@yahoo.de on Sat, May 25, 2002 at 01:51:04PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, May 25, 2002 at 01:51:04PM +0200, karsten wiese wrote:
> somebody working on drivers for this card?

There is an OSS driver at http://andrewtv.org/linux-multisound/index.jsp
ALSA port is mentioned in page but AFAIK the 30% status hasn't changed in
years. Someone would have to port the driver. I think the cards use a
cs42xx chip for pcm stuff, so a driver with only pcm and mixer shouldn't
be too hard. Just my gut feeling...

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
