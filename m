From: Mathieu Dube <mdube@8d.com>
Subject: Re: sinus example
Date: Thu, 21 Mar 2002 09:36:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <02032109364600.01822@mdube.usine.8D.com>
References: <Pine.LNX.4.33.0203210818440.487-100000@pnote.perex-int.cz>
Reply-To: mdube@8d.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0203210818440.487-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I use the snd-card-ens1371 which work alright with the 0.5.

But isnt it weird that all the other call to setup the sw_params work??

Thanks
-Mat

On Thursday 21 March 2002 02:19, Jaroslav Kysela wrote:
> On Wed, 20 Mar 2002, Mathieu Dube wrote:
> > Hi,
> > 	I tried to run the example given in the documentation and what I get is
> > this: ALSA lib pcm_hw.c:167:(snd_pcm_hw_sw_params)
> > SNDRV_PCM_IOCTL_SW_PARAMS failed: Invalid argument
> >
> > Im wondering what it could be and what error I could look for to solve
> > that.
>
> Hardware?
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com

-- 
Mathieu Dube -- mdube@8d.com
8D Technologies Inc.
http://www.8d.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
