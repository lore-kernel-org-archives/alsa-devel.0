From: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: SPDIF and cs46xx ?
Date: Fri, 4 Apr 2003 19:25:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030404172526.GB12549@ulima.unil.ch>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net> <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch> <3E864424.6060707@cucumelo.org> <20030330144633.GA9474@ulima.unil.ch> <20030331114752.GA3187@wotan.suse.de> <20030404114623.GB9836@ulima.unil.ch> <3E8DC881.2070401@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E8DC881.2070401@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: "Dr. Werner Fink" <werner@suse.de>, Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 04, 2003 at 08:01:37PM +0200, Benny Sjostrand wrote:

> I would like to get to the bottom of this problem.
> Let's try figure out exactly which lines of code produces thoose=20
> messages: "S/P-DIF: Period size not available: Invalid argument" and=20
> "S/P-DIF: unable to establish BitStreamOut for none audio PCM"

The whole archive could be found under
http://prdownloads.sourceforge.net/sourceforge/bitstreamout/

And I have put the file spdif.c under
http://ulima.unil.ch/greg/linux/spdif.c

In this file, there are the errors messages, unfortunately it's far too
complicated for my basic programming knowledge ;-)

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
