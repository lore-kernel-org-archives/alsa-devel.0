From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: nVidia nForce sound
Date: Sat, 9 Feb 2002 23:45:52 -0800 (PST)
Message-ID: <20020210074552.A0B852755@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Lars Magne Ingebrigtsen <larsi@gnus.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

what is the output of cat /proc/interupts ?

That should tell you what chip the soundcard uses. Then you can check this against the list of supported cards or ask again on the alsa-user list?



--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/Linux_Audio_Users_Guide/


--- Lars Magne Ingebrigtsen <larsi@gnus.org> wrote:
>I've got an nForce-based motherboard with built-in audio.  Does
>support for these boards exist in ALSA?  
>
>-- 
>(domestic pets only, the antidote for overdose, milk.)
>   larsi@gnus.org * Lars Magne Ingebrigtsen
>
>
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel

_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
